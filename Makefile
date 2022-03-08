HELM != helm

gen-expected:
	${HELM} template --namespace=default --values=tests/mapserver.yaml mapserver . > tests/mapserver-expected.yaml || \
		${HELM} template --debug --namespace=default --values=tests/mapserver.yaml mapserver .
	sed -i 's/[[:blank:]]\+$$//g'  tests/mapserver-expected.yaml
	${HELM} template --namespace=default --values=tests/qgis.yaml qgis . > tests/qgis-expected.yaml || \
		${HELM} template --debug --namespace=default --values=tests/qgis.yaml qgis .
	sed -i 's/[[:blank:]]\+$$//g'  tests/qgis-expected.yaml
