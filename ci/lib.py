#!/usr/bin/env python3

import json


def check_deployment_status(deployments):
    for deployment in deployments["items"]:
        if not deployment["status"]:
            print(f'Waiting status for {deployment["metadata"]["name"]}')
            return False

        for condition in deployment["status"].get("conditions", []):
            if not condition["status"]:
                print(
                    f'::group::Deployment {deployment["metadata"]["name"]} not ready: {condition["message"]}'
                )
                print(json.dumps(condition, indent=4))
                print("::endgroup::")
                return False

        # Ignore on QGIS server
        if deployment["spec"]["replicas"] == 2:
            return True

        if deployment["status"].get("unavailableReplicas", 0) != 0:
            print(
                f'::group::Deployment {deployment["metadata"]["name"]} not ready there is {deployment["status"].get("unavailableReplicas", 0)} '
                "unavailable replicas"
            )
            print(json.dumps(deployment["status"], indent=4))
            print("::endgroup::")
            return False

    return True


def check_pod_status(pods):
    for pod in pods["items"]:
        for condition in pod["status"].get("conditions", []):
            if not condition["status"]:
                print(
                    f'::group::Pod not ready in {pod["metadata"]["name"]}: {condition.get("message", condition["type"])}'
                )
                print(json.dumps(condition, indent=4))
                print("::endgroup::")
                return False

        def check_container_status(pod, status, is_init=False):
            del is_init
            good = status["ready"]
            if status["name"] == "sleep" and not good:
                good = True

            if not good:
                waiting = status["state"].get("waiting")
                terminated = status["state"].get("terminated")
                state = waiting if waiting else terminated
                status_message = state.get("message", state.get("reason", "")) if state else ""
                if not status_message:
                    state = status.get("lastState", {}).get("terminated", {})
                    status_message = state.get("message", state.get("reason", "")) if state else ""
                status_message_long = status_message.strip()
                if "message" in status.get("lastState", {}).get("terminated", {}):
                    status_message_long = status["lastState"]["terminated"]["message"]
                status_message = status_message.split("\n")[0]
                status_message = status_message.strip()
                if status_message == "Completed":
                    print("Container successfully completed")
                    return True
                print(f'::group::Container not ready in {pod["metadata"]["name"]}: {status_message}')
                if status_message_long != status_message:
                    print(status_message_long)
                print(json.dumps(status, indent=4))
                print("::endgroup::")
                return False
            return True

        for status in pod["status"].get("initContainerStatuses", []):
            if not check_container_status(pod, status, True):
                return False
        for status in pod["status"].get("containerStatuses", []):
            if not check_container_status(pod, status):
                return False

    return True
