1. Add the `DISCORD_WEBHOOK_URL` secret to your repository with the value of your webhook url.
2. Add the following lines to your Github Actions job steps.
```yaml
- name: Push Success to Discord
   if: success()
   env:
      WEBHOOK_URL: ${{ secrets.DISCORD_WEBHOOK_URL }}
   run: |
   wget https://gist.githubusercontent.com/JoeZwet/3365d05fb720aa5d498fac4d1c93fb56/raw/dcb7f984d7c2cbaa6be8c4ce3b83f7f983ce8fc1/discord.sh
     chmod +x discord.sh
     ./discord.sh success $WEBHOOK_URL
- name: Push Failure to Discord
   if: failure()
   env:
     WEBHOOK_URL: ${{ secrets.DISCORD_WEBHOOK_URL }}
   run: |
    wget https://gist.githubusercontent.com/JoeZwet/3365d05fb720aa5d498fac4d1c93fb56/raw/dcb7f984d7c2cbaa6be8c4ce3b83f7f983ce8fc1/discord.sh
    chmod +x discord.sh
    ./discord.sh failure $WEBHOOK_URL
```
