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
async def roll(dice: str):
    """Rolls a dice in NdN format."""
    try:
        rolls, limit = map(int, dice.split('d'))
    except Exception:
        await bot.say('Format has to be in NdN!')
        return

    total = 0
    result = ', '.join(str(random.randint(1, limit)) for r in range(rolls))

    for r in result.split(','):
        total += int(r.strip())

    await bot.say("__Your results for **" + str(rolls) + "** D**" + str(limit) + "**__\n" + ":game_die: " +  result + "\nTotal [**" + str(total) +  "**]")

@bot.command()
async def testembed():
    """embed tester!"""
    message = "This is only a test!"
    title = "Embed title!"
    embed = discord.Embed()
    embed.description = message
    embed.title = title
    embed.colour = 0xDEADBF
    await bot.say(embed=embed)


if __name__ == '__main__':
    print('we are in main!')
    bot.run(TOKEN)    
