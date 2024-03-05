FROM python:3.13-rc-slim

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y apache2-utils \
&& apt-get clean -y
WORKDIR /app

COPY make-data.py /app
COPY generate-votes.sh /app

RUN python3 make-data.py

CMD ["/bin/bash", "generate-votes.sh"]
