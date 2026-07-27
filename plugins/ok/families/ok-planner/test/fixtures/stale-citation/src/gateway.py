def ingest(stream, version, body, device):
    record_id = accept(stream, version, body, device)
    return record_id
