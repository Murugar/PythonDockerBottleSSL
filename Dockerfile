FROM python:3.6.3
RUN useradd -r --no-user-group test && \
    echo test:test | chpasswd
WORKDIR /app
RUN openssl req -new -x509 -days 365 -nodes -out cacert.pem -keyout privkey.pem -subj "/C=AA/ST=State/L=Location/O=IT/CN=test.com"
COPY Pipfil* /app/
RUN pip install pipenv && pipenv install
COPY main.py .
COPY index.html .

EXPOSE 443
ENTRYPOINT ["pipenv",  "run", "python", "main.py"]
