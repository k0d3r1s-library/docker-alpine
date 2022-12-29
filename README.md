# Split action

Action to split monorepo into multiple repositories
___

## Example usage

```yaml
on: [push]

jobs:
  split_job:
    runs-on: ubuntu-22.04
    name: split
    steps:
      - name: Get branch name
        shell: bash
        run: echo "::set-output name=branch::${GITHUB_REF#refs/heads/}"
        id: branch
      - name: Split monorepo
        id: split
        uses: docker://k0d3r1s/alpine:action-split
        env:
          BRANCH: ${{ steps.branch.outputs.branch }}
          REPO: ${{ github.repository }}
          GH_TOKEN: ${{ secrets.GH_TOKEN }} # GitHub PA Token
          COMPONENTS_URL: https://raw.githubusercontent.com/k0d3r1s-library/docker-alpine/master/components.json # << EXAMPLE! URL location of component list
```
___
## Example component.json list content
```json
[
    {
        "path": "src/Vairogs/Addon",
        "repo": "https://GH_TOKEN@github.com/vairogs/addon.git"
    },
    {
        "path": "src/Vairogs/Addon/Auth",
        "repo": "https://GH_TOKEN@github.com/vairogs/addon-auth.git"
    }
]
```
