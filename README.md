# Discord Webhook for Github Actions
## Setup
1. In Github secrets, add a `WEBHOOK_URL` variable with the Discord web hook URL
1. In your Github actions yml file, add this to reference the variable you just created:
    - To see a real example, visit [here](https://github.com/unthreaded/git-hooks/blob/d1f4df504dab979c1406daf67e13f144feb7d47b/.github/workflows/build.yml#L43). 
    ```yaml
        - name: Send Webhook Notification
          if: always()
          env:
            JOB_STATUS: ${{ job.status }}
            WEBHOOK_URL: ${{ secrets.WEBHOOK_URL }}
          run: |
            git clone https://github.com/DiscordHooks/github-actions-discord-webhook.git webhook
            bash webhook/send.sh $JOB_STATUS $WEBHOOK_URL
          shell: bash
    ```
1. Enjoy!
