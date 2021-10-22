HELM != helm3

gen-expected:
	${HELM} template --namespace=default --values=tests/mapserver.yaml mapserver . > tests/mapserver-expected.yaml
	sed -i 's/[[:blank:]]\+$$//g'  tests/mapserver-expected.yaml
	${HELM} template --namespace=default --values=tests/qgis.yaml qgis . > tests/qgis-expected.yaml
	sed -i 's/[[:blank:]]\+$$//g'  tests/qgis-expected.yaml
