def ingest(stream, version, body):
    record_id = accept(stream, version, body)
    return record_id
