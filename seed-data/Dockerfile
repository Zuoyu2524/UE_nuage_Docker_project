FROM python:3.13-rc-slim

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y apache2-utils \
&& apt-get clean -y

COPY make-data.py .
COPY generate-votes.sh .

RUN python3 make-data.py

CMD ["/bin/bash", "generate-votes.sh"]
