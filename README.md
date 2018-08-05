# Travis-cli from a container

## Running

Two volumes `/data` and `/root/.travis` are defined.

The `/data` is where the Docker HOST (your machine) shouldprobably be mapped - this would have any scripts, data, etc. that is needed.
> NOTE: this is essentially your project directory

The `/root/.travis` is where any of Travis configuration options are store or end up...

## Example

From your home path, first we'll make some local directory and run a task

```
docker run -it --rm -v `pwd`:/data -v $HOME/.travis:/root/.travis cicorias/travis-cli
```
Mount your project directory to /data in the container.

Mount your travis configuration to /root/.travis in the container.