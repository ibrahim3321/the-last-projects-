FROM python:3.11-slim
WORKDIR /app
RUN pip install --no-cache-dir flask requests gunicorn
COPY app.py /app/
EXPOSE 8080
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app", "--workers=2", "--threads=2", "--timeout=30"]
