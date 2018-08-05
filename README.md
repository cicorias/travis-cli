# Travis-cli from a container

## Running

Two volumes `/data` and `/root/.travis` are defined.

The `/data` is where the Docker HOST (your machine) shouldprobably be mapped - this would have any scripts, data, etc. that is needed.
> NOTE: this is essentially your project directory AND the **git repo**

The `/root/.travis` is where any of Travis configuration options are store or end up...

## Example

From your home path, first we'll make some local directory and run a task

```
mkdir mywork
cd mywork
```

### macOS and Linux
This will use or create the `.travis` folder in your profile path.
```
docker run -it --rm -v `pwd`:/data -v $HOME/.travis:/root/.travis cicorias/travis-cli login
```

### Windows
This example creates a separate folder for the `.travis` profile infomration
>WARNING: this directory contains secrets / tokens and should never be shared and should have proper ACLs to prevent others from reading
```
docker run -it --rm -v C:\g\containers\travis-cli\travis:/root/.travis -v C:\g\containers\travis-cli\:/data cicorias/travis-cli login
```

#### PowerShell (Windows for now)
This does the same as above, but uses PowerShell's `${PWD}` for the absolute path of the current working directory in the shell.

>WARNING: this directory contains secrets / tokens and should never be shared and should have proper ACLs to prevent others from reading
```
docker run -it --rm -v ${PWD}/travis:/root/.travis -v ${PWD}:/data cicorias/travis-cli login
```


### Verify Login persists
Since the `docker run` command used the `--rm` parameter, the container is removed after stopping. This makes the container itself stateless. All state needed should be saved to `/data` which is mapped to the host if the `-v` paramemter is passed properly. Same for the `.travis` volumne

Now, run a command `whomai` to see the logged on information

```
docker run -it --rm -v ${PWD}/travis:/root/.travis -v ${PWD}:/data cicorias/travis-cli whoami
```

For me my output was:
```
C:\travis-cli [master ≡ +1 ~1 -0 !]> docker run -it --rm -v ${PWD}\travis:/root/.travis -v ${PWD}\data:/data cicorias/travis-cli whoami
You are cicorias (Shawn Cicoria)
```