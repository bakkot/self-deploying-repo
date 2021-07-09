# Self-deploying repo

This repository updates its own [gh-pages](https://pages.github.com/) branch whenever the main branch is pushed, and therefore its [website](https://bakkot.github.io/self-deploying-repo/). It is intended to serve as an example of how to make your own repository do that.

## How to

Basically, make a deploy key with write access, store the secret key in a GitHub secret, and set up a [GitHub Action](https://docs.github.com/en/actions) which consumes the secret and uses it to push to the repo.

In more detail:

1. [Set up a deploy key](https://docs.github.com/en/developers/overview/managing-deploy-keys#deploy-keys) for your repository. Make sure it has write access.
    1. You can generate a new keypair with `ssh-keygen -t ed25519 -f deploy-key -N '' -C 'bot@example.com'`. Make sure not to commit the resulting `deploy-key` or `deploy-key.pub` files.
1. Set up a new [repository secret](https://docs.github.com/en/actions/reference/encrypted-secrets) named `GH_DEPLOY_KEY` holding the private key. You can (and should) now discard your local copies of the keypair.
1. Copy `.github/workflows/deploy.yml`, `scripts/build.sh`, and `scripts/deploy.sh` from this project to yours, keeping the same paths.
1. Edit `.github/workflows/deploy.yml` to suit your project. You must update the `if:` line to list your actual repository instead of this one. Also check the main branch name (e.g. yours might be `master` rather than `main`). You can also add any additional setup steps necessary to run the build prior to the `build.sh` step, like [setting up Node](https://docs.github.com/en/actions/guides/building-and-testing-nodejs#starting-with-the-nodejs-workflow-template).
1. Edit `scripts/build.sh` to contain the necessary build steps for your project. Ensure it results in a directory named `out` containing all and only the files you want to deploy.
1. Edit the variables in `scripts/deploy.sh` to suit your project.
1. Push.

That's it! Your gh-pages branch should now update whenever you update the main branch of your repository, starting with the commit you just pushed.

## Note on history

This project assumes you want to _overwite_ the gh-pages branch on each commit, losing all history on that branch. You can tweak it to preserve the history if you want, but it's a little more involved: you'll need to modify `scripts/deploy.sh` to clone and update the existing repo rather than pushing a fresh version.
