import discord
from discord.ext import commands
import random
import json
import os
import sys

def get_script_path():
    return os.path.dirname(os.path.realpath(sys.argv[0]))

with open(get_script_path() + '/config.json', 'r') as f:
    CONFIG = json.load(f)

TOKEN = CONFIG['Token']

bot = commands.Bot(command_prefix=CONFIG['prefix'], description=CONFIG['Description'])

@bot.event
async def on_ready():
    print('Logged in as')
    print(bot.user.name)
    print(bot.user.id)
    print('------')

@bot.command()
async def join(ctx):
    """join a voice channel"""
    user = ctx.message.author
    channel = user.voice.channel
    await channel.connect()

@bot.command()
async def leave(ctx):
    """leave a voice channel"""
    await ctx.voice_client.disconnect()
    
if __name__ == '__main__':
    print('we are in main!')
    bot.run(TOKEN)    