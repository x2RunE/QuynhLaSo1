const { Client, GatewayIntentBits, ChannelType } = require('discord.js-selfbot-v13')
const prompt = require('prompt-sync')()
const notifier = require('node-notifier');

const User_Token = 'MTA5MzUwNDcxNTkzMDc0Mjg0Ng.GWjGFl._XqfPR2YXZJfRxA1bpMJNmHgzKGs8n-CWN9DJs' // prompt('Enter your Discord Token : ')
const CHANNEL_ID = '1364498257274867824' // prompt('Enter Channel ID : ');

global.CaptchaDetected = false
global.Status = null
global.cowoncy = 0

console.clear()

const client = new Client({
  intents: [
    "GUILDS",
    "GUILD_MESSAGES",
    "MESSAGE_CONTENT",
    "DIRECT_MESSAGES"
  ],
  partials: ["CHANNEL"]
});


function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

client.on('messageCreate', async (message) => {
  const lower = message.content.replace(/[\u200B-\u200D\uFEFF]/g, '').toLowerCase()
  if (
    message.channel.id === CHANNEL_ID &&
    /captcha/.test(lower) &&
    !global.CaptchaDetected &&
    message.author.id === '408785106942164992') {
    const channel = client.channels.cache.get(CHANNEL_ID);
    if (channel) {
      channel.send('**[ Auto OwO v1.0.1 ] Captcha detected !**');
    }
    notifier.notify({
      title: 'Captcha Detected !',
      message: 'Please solve the OwO captcha now.',
      sound: true,
      wait: false,
      appID: 'Radiant Auto OwO v1.0.1',
      timeout: 10
    });
    global.CaptchaDetected = true;
  }
  if (
    message.channel.type === 'DM' &&
    global.CaptchaDetected &&
    message.author.id === '408785106942164992'
  ) {
    const channel = client.channels.cache.get(CHANNEL_ID);
    if (channel) {
      channel.send('**[ Auto OwO v1.0.1 ] Captcha verified !**');
    }
    global.CaptchaDetected = false;
  }
});

client.on('messageCreate', async (message) => {
  if (
    message.channel.id === CHANNEL_ID &&
    message.author.id === '408785106942164992' &&
    /you currently have/.test(message.content)
  ) {
    const msg = message.content;
    const clean = msg
      .replace(/[\u200B-\u200D\uFEFF]/g, '')
      .replace(/\*\*|__|<.*?>|[^\x20-\x7E]/g, '');

    const match = clean.match(/you currently have\s*([\d,]+)\s*cowoncy/i);
    global.cowoncy = match ? match[1] : 0
  }
});

client.once('ready', async () => {
  const channel = client.channels.cache.get(CHANNEL_ID)
  if (!channel) {
    return
  }
  await channel.send('**Radiant Hub | Auto OwO v1.0.1 Actived** 🥰')
  while (true) {
    console.clear()
    console.log(`
Radiant Hub | Auto OwO v1.0.1

Account : ${client.user.tag}
Status : ${global.Status}
Current cowoncy : ${global.cowoncy}
Time : ${new Date().toLocaleTimeString()}
`)
    const arr = ['ocash','oh','ob','osell all','oteam','oz','oquest','oweapon']
    // const arr2 = ['oh','ob','oteam','oz']
    for (let i = 0;i < arr.length;i++) {
        if (! global.CaptchaDetected) {
          global.Status = 'Farming'
          if (arr[i] === 'osell all') {
            await sleep(1000)
          }
          await channel.send(arr[i])
          await sleep(i * 1000)
      } else {
          global.Status = 'Captcha Detected'
          await sleep(2500)
      }
    }
    await sleep(3000)
  }
});

client.login(User_Token);
