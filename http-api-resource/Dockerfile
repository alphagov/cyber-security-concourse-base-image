FROM aequitas/http-api-resource AS HTTP_API

FROM python:3.7-alpine

COPY --from=HTTP_API . .
RUN pip install --no-cache-dir -r requirements.txt

COPY --from=HTTP_API /opt/resource/ /opt/resource/
COPY --from=HTTP_API /opt/resource-tests/ /opt/resource-tests/

RUN /opt/resource-tests/test.sh
