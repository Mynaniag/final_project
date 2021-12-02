FROM python:3.6-alpine3.13
RUN addgroup -S pythonGr && adduser -S pythonUs -G pythonGr
COPY ./application/ /home/pythonUs/
WORKDIR /home/pythonUs/
RUN pip install --no-cache-dir aiohttp multidict==4.5.2 yarl==1.3.0 && python3 setup.py install
USER pythonUs
RUN echo "Hi jenkins"
CMD ["python3","-m","demo"]
