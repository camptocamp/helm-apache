#!/usr/bin/env python3

import json
import subprocess
import sys
import time

from lib import check_deployment_status, check_pod_status


def main() -> None:
    labels = sys.argv[1]
    for _ in range(20):
        time.sleep(10)
        success = True
        pods = subprocess.run(
            ["kubectl", "get", "pods", "--output=json", "-l", labels],
            stdout=subprocess.PIPE,
            check=True,
        )
        success &= check_pod_status(json.loads(pods.stdout))
        if success:
            sys.exit(0)
    sys.exit(1)


if __name__ == "__main__":
    main()
