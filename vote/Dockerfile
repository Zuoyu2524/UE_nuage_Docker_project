FROM python:3.13-rc-slim
WORKDIR /app
ADD . /app/

EXPOSE 5000
RUN pip install -r requirements.txt
CMD [ "python", "app.py" ]