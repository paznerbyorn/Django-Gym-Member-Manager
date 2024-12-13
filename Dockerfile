FROM python:3.10-slim
RUN apt-get update && apt-get install -y \
    build-essential \
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libtiff-dev \
    libopenjp2-7-dev \
    libimagequant-dev \
    libjpeg62-turbo-dev \
    && apt-get clean
WORKDIR /app
COPY . /app
EXPOSE 8000
RUN pip install -r requirements.txt
RUN python manage.py collectstatic --noinput
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi:application"]