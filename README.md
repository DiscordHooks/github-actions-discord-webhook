# Discord Webhook for Github Actions
## Setup
1. In Github secrets, add a `WEBHOOK_URL` variable with the Discord web hook URL
1. In your Github actions yml file, add this to reference the variable you just created:
    - To see a real example, visit [here](https://github.com/unthreaded/git-hooks/blob/92ea6bde348431fbe25d05c33398c969eec5d3ee/.github/workflows/build.yml#L48). 
    ```yaml
        - uses: actions/setup-ruby@v1
        - name: Send Webhook Notification
          if: always()
          env:
            JOB_STATUS: ${{ job.status }}
            WEBHOOK_URL: ${{ secrets.WEBHOOK_URL }}
            HOOK_OS_NAME: ${{ runner.os }}
            WORKFLOW_NAME: ${{ github.workflow }}
          run: |
            wget https://raw.githubusercontent.com/DiscordHooks/github-actions-discord-webhook/master/send.sh
            chmod +x send.sh
            ./send.sh $JOB_STATUS $WEBHOOK_URL
    ```
1. Enjoy!