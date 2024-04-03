FROM python:3.9-slim

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y apache2-utils \
&& apt-get clean -y
WORKDIR /app

COPY make-data.py .
COPY generate-votes.sh .

RUN python make-data.py

CMD [ "/bin/sh", "./generate-votes.sh" ]