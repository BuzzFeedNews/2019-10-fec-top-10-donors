default: filings

filings:
	mkdir -p fetched/filings
	python scripts/download-filings.py
