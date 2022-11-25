

## TODO

- set checks to avoid creating duplicates or messing up stuff

# SET UP:

The system is made to be replicable just by copying the repository to another directory and *only* editing the `.env` file, so that
the containers are clones of each other and only differ by the name they're called. It should become easy then to deploy and configure multiple 
instances. **Take care** of the names of the volumes as well, as there should be one for each container, in order to keep configs and data.

