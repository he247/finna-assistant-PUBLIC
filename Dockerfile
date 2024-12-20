FROM python:3.10-slim-bookworm

WORKDIR /usr/src/app
RUN pip install --no-cache-dir gradio openai pandas numpy
COPY app.py generate_embeddings.py system_prompt.md system_prompt_fi.md system_prompt_fi_en.md organizations.csv journals.csv tools.json custom.css .

ARG AZURE_OPENAI_KEY
ENV AZURE_OPENAI_KEY=$AZURE_OPENAI_KEY
RUN python generate_embeddings.py

EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"

RUN (date -u +"%Y-%m-%d %H:%M:%S" --date='2 hours') > date.txt

CMD ["python", "-u", "app.py"]