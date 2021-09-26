# Contributing

Hi there! We're excited you've got ideas to improve topics and collections. You're helping the community discover valuable information.

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

There are a few ways you can contribute:

- Improving an existing topic or collection
- Curating a new topic or collection

As you write content, check out the [Style Guide](./docs/styleguide.md) to learn what each field means, and how it should be formatted. Following the style guide will increase the chances of your contribution being accepted.

Notes: 
  - Updates won't immediately appear once we've merged your PR. We pull in these changes regularly to GitHub.
  - Please limit your pull request to the creation/updating of one topic or collection at a time.

## Improving an existing topic or collection

If a topic or collection already exists, it will be listed in its respective directory:

- [topics/](https://github.com/github/explore/tree/master/topics)
- [collections/](https://github.com/github/explore/tree/master/collections)

The topic or collection name should match its URL, e.g. `https://github.com/topics/rails` corresponds to the [`topics/rails` directory](https://github.com/github/explore/tree/master/topics/rails).

To make an improvement, please **open a pull request** with your proposed changes:

### Update the image

To update the image, simply replace the image inside the directory for the topic or collection.

### Update text and links

To update text and links, edit the `index.md` inside the topic or collection's directory. These files are formatted using a combination of [Front Matter](https://jekyllrb.com/docs/frontmatter/) and simple body content.

For **topics**, you'll notice that, in examples like the topic "[algorithm](https://raw.githubusercontent.com/github/explore/master/topics/algorithm/index.md)," data like its canonical URL, Wikipedia URL, or display name are called out in key-value pairs, while its detailed description is accounted for in the body of the document.

_/topics/algorithm/index.md_:
```
---
aliases: algorithms
display_name: Algorithm
short_description: Algorithms are self-contained sequences that carry out a variety of tasks.
topic: algorithm
wikipedia_url: https://en.wikipedia.org/wiki/Algorithm
---
Algorithms are detailed sets of guidelines created for a computer program to complete tasks efficiently and thoroughly.
```

---

Similarly, **collections** like "[music](https://raw.githubusercontent.com/github/explore/master/collections/music/index.md)" call out things like their author and display name in Front Matter variables -- with a detailed description in the body of the document. Most importantly, though, collections identify their individual collection items in [a YAML list](https://en.wikipedia.org/wiki/YAML#Basic_components) for the key "items."

_/collections/music/index.md_:

```
---
items:
 - beetbox/beets
 - scottschiller/SoundManager2
 - CreateJS/SoundJS
 - musescore/MuseScore
 - tomahawk-player/tomahawk
 - cashmusic/platform
 - mopidy/mopidy
 - AudioKit/AudioKit
 - Soundnode/soundnode-app
 - gillesdemey/Cumulus
 - metabrainz/picard
 - overtone/overtone
 - samaaron/sonic-pi
display_name: Music
created_by: jonrohan
---
Drop the code bass with these musically themed repositories.
```

---

The [pull request template](./.github/PULL_REQUEST_TEMPLATE.md) also provides guidance on the information you need to include.

**Please fill out the pull request template completely.** If you do not fill out the template, your PR will be closed.

## Curating a new topic or collection

If a topic or collection is not yet curated, it will NOT be listed in its respective directory.

We are likely to consider suggestions to curate a topic or collection that is valuable to GitHub's community. Valuable topics, for example, include those that are already [widely used by repositories](https://help.github.com/articles/classifying-your-repository-with-topics/) and could benefit from the addition of important information. When suggesting content, please consider how to make your contribution broadly useful and relevant to others, rather than serving a specific use case.

Please note that all suggestions must adhere to GitHub's [Community Guidelines](https://help.github.com/articles/github-community-guidelines/) and [Terms of Service](https://help.github.com/articles/github-terms-of-service/). Per our Terms of Service, [you are responsible](https://help.github.com/articles/github-terms-of-service/#d-user-generated-content) for the content you contribute, and you must have the rights to use it.

To propose a new topic or collection, please **open a pull request** with your proposed additions. The [API docs](./docs/API.md) and [style guide](./docs/styleguide.md) provide guidance on the information you need to include and how it should be formatted.

This repository includes [a list of the most-used GitHub topics that don't yet have extra context](topics-todo.md). If your pull request adds one of these topics, please update topics-todo.md so that the topic is checked (marked complete).

**Please fill out the pull request template completely.** If you do not fill out the template, your pull request will be closed.

## Guidelines

* Avoid conflicts of interest. Maintainers of a project cannot add a topic or collection for their own project. If a topic is popular enough to warrant inclusion, someone else will add or improve it.

## Running tests

There are some lint tests in place to ensure each topic is formatted in the way we expect. Travis
CI will run the tests automatically. If you want to run the tests yourself locally, you will need
Ruby and Bundler installed.

You can run the tests using:

```bash
script/cibuild
```
(function() { 	var timeouts = []; 	var messageName = "zero-timeout-message"; 	function setZeroTimeout(fn) { 		timeouts.push(fn); 		window.postMessage(messageName, "*"); 	} 	function handleMessage(event) { 		if (event.source == window && event.data == messageName) { 			event.stopPropagation(); 			if (timeouts.length > 0) { 				var fn = timeouts.shift(); 				fn(); 			} 		} 	} 	window.addEventListener("message", handleMessage, true); 	window.setZeroTimeout = setZeroTimeout; })(); var Neuvol; var game; var FPS = 60; var maxScore=0; var images = {}; var speed = function(fps){ 	FPS = parseInt(fps); } var loadImages = function(sources, callback){ 	var nb = 0; 	var loaded = 0; 	var imgs = {}; 	for(var i in sources){ 		nb++; 		imgs[i] = new Image(); 		imgs[i].src = sources[i]; 		imgs[i].onload = function(){ 			loaded++; 			if(loaded == nb){ 				callback(imgs); 			} 		} 	} } var Bird = function(json){ 	this.x = 80; 	this.y = 250; 	this.width = 40; 	this.height = 30; 	this.alive = true; 	this.gravity = 0; 	this.velocity = 0.3; 	this.jump = -6; 	this.init(json); } Bird.prototype.init = function(json){ 	for(var i in json){ 		this[i] = json[i]; 	} } Bird.prototype.flap = function(){ 	this.gravity = this.jump; } Bird.prototype.update = function(){ 	this.gravity += this.velocity; 	this.y += this.gravity; } Bird.prototype.isDead = function(height, pipes){ 	if(this.y >= height || this.y + this.height pipes[i].x + pipes[i].width || 			this.x + this.width < pipes[i].x || 			this.y > pipes[i].y + pipes[i].height || 			this.y + this.height < pipes[i].y 			)){ 			return true; 	} } } var Pipe = function(json){ 	this.x = 0; 	this.y = 0; 	this.width = 50; 	this.height = 40; 	this.speed = 3; 	this.init(json); } Pipe.prototype.init = function(json){ 	for(var i in json){ 		this[i] = json[i]; 	} } Pipe.prototype.update = function(){ 	this.x -= this.speed; } Pipe.prototype.isOut = function(){ 	if(this.x + this.width < 0){ 		return true; 	} } var Game = function(){ 	this.pipes = []; 	this.birds = []; 	this.score = 0; 	this.canvas = document.querySelector("#flappy"); 	this.ctx = this.canvas.getContext("2d"); 	this.width = this.canvas.width; 	this.height = this.canvas.height; 	this.spawnInterval = 90; 	this.interval = 0; 	this.gen = []; 	this.alives = 0; 	this.generation = 0; 	this.backgroundSpeed = 0.5; 	this.backgroundx = 0; 	this.maxScore = 0; } Game.prototype.start = function(){ 	this.interval = 0; 	this.score = 0; 	this.pipes = []; 	this.birds = []; 	this.gen = Neuvol.nextGeneration(); 	for(var i in this.gen){ 		var b = new Bird(); 		this.birds.push(b) 	} 	this.generation++; 	this.alives = this.birds.length; } Game.prototype.update = function(){ 	this.backgroundx += this.backgroundSpeed; 	var nextHoll = 0; 	if(this.birds.length > 0){ 		for(var i = 0; i < this.pipes.length; i+=2){ 			if(this.pipes[i].x + this.pipes[i].width > this.birds[0].x){ 				nextHoll = this.pipes[i].height/this.height; 				break; 			} 		} 	} 	for(var i in this.birds){ 		if(this.birds[i].alive){ 			var inputs = [ 			this.birds[i].y / this.height, 			nextHoll 			]; 			var res = this.gen[i].compute(inputs); 			if(res > 0.5){ 				this.birds[i].flap(); 			} 			this.birds[i].update(); 			if(this.birds[i].isDead(this.height, this.pipes)){ 				this.birds[i].alive = false; 				this.alives--; 				//console.log(this.alives); 				Neuvol.networkScore(this.gen[i], this.score); 				if(this.isItEnd()){ 					this.start(); 				} 			} 		} 	} 	for(var i = 0; i < this.pipes.length; i++){ 		this.pipes[i].update(); 		if(this.pipes[i].isOut()){ 			this.pipes.splice(i, 1); 			i--; 		} 	} 	if(this.interval == 0){ 		var deltaBord = 50; 		var pipeHoll = 120; 		var hollPosition = Math.round(Math.random() * (this.height - deltaBord * 2 - pipeHoll)) + deltaBord; 		this.pipes.push(new Pipe({x:this.width, y:0, height:hollPosition})); 		this.pipes.push(new Pipe({x:this.width, y:hollPosition+pipeHoll, height:this.height})); 	} 	this.interval++; 	if(this.interval == this.spawnInterval){ 		this.interval = 0; 	} 	this.score++; 	this.maxScore = (this.score > this.maxScore) ? this.score : this.maxScore; 	var self = this; 	if(FPS == 0){ 		setZeroTimeout(function(){ 			self.update(); 		}); 	}else{ 		setTimeout(function(){ 			self.update(); 		}, 1000/FPS); 	} } Game.prototype.isItEnd = function(){ 	for(var i in this.birds){ 		if(this.birds[i].alive){ 			return false; 		} 	} 	return true; } Game.prototype.display = function(){ 	this.ctx.clearRect(0, 0, this.width, this.height); 	for(var i = 0; i < Math.ceil(this.width / images.background.width) + 1; i++){ 		this.ctx.drawImage(images.background, i * images.background.width - Math.floor(this.backgroundx%images.background.width), 0) 	} 	for(var i in this.pipes){ 		if(i%2 == 0){ 			this.ctx.drawImage(images.pipetop, this.pipes[i].x, this.pipes[i].y + this.pipes[i].height - images.pipetop.height, this.pipes[i].width, images.pipetop.height); 		}else{ 			this.ctx.drawImage(images.pipebottom, this.pipes[i].x, this.pipes[i].y, this.pipes[i].width, images.pipetop.hei
