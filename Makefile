
image:

	@docker build -t nahlaalhebsi/fb-random-post-from-feed:latest .

message:

	@docker run -it --rm -u nahlaalhebsi --env-file .env \
		-v $(PWD):/home/nahlaalhebsi/fb-random-post-from-feed \
		-w /home/nahlaalhebsi/fb-random-post-from-feed \
	nahlaalhebsi/fb-random-post-from-feed:latest python entrypoint.py

console:

	@docker run -it --rm -u nahlaalhebsi --env-file .env \
		-v $(PWD):/home/nahlaalhebsi/fb-random-post-from-feed \
		-w /home/luisalejandro/fb-random-post-from-feed \
	nahlaalhebsi/fb-random-post-from-feed:latest bash
