# Discord Webhook for Github Actions
## Setup
1. In Github secrets, add a `WEBHOOK_URL` variable with the Discord web hook URL
1. In your Github actions yml file, add this to reference the variable you just created:
    - To see a real example, visit [here](https://github.com/unthreaded/git-hooks/blob/80e914105c0a9d94282f8f1b0a1b39ea8d59dc33/.github/workflows/build.yml#L36). 
    ```yaml
        - name: Send Webhook Notification
          if: always()
          env:
            JOB_STATUS: ${{ job.status }}
            WEBHOOK_URL: ${{ secrets.WEBHOOK_URL }}
          run: |
            wget https://raw.githubusercontent.com/DiscordHooks/github-actions-discord-webhook/master/send.sh
            chmod +x send.sh
            ./send.sh $JOB_STATUS $WEBHOOK_URL
    ```
1. Enjoy!