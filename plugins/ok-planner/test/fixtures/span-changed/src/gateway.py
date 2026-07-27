def ingest(stream, version, body):
    validate(body)
    record_id = accept(stream, version, body)
    return record_id
