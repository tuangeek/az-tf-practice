FROM public.ecr.aws/docker/library/python:3.12

WORKDIR /app

RUN pip install poetry

COPY poetry.lock pyproject.toml .

RUN poetry install

COPY app .

EXPOSE 8501

CMD poetry run streamlit run app/app.py --server.address='0.0.0.0'