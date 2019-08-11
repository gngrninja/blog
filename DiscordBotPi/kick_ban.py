import discord
from discord.ext import commands
from discord.ext.commands import has_permissions

TOKEN = "your_token_here"
DESCRIPTION = "Discord bot running on Python!"

bot = commands.Bot(command_prefix="?", description=DESCRIPTION)

@bot.event
async def on_ready():
    print('Logged in as')
    print(bot.user.name)
    print(bot.user.id)
    print('------')
    
@bot.command(pass_context=True)
@has_permissions(kick_members=True)
async def kick(ctx, member: discord.User=None):
    """ Simple kick command """
    await ctx.guild.kick(member)
    print("kicked" + " " + str(member))

@bot.command(pass_context=True)
@has_permissions(ban_members=True)
async def ban(ctx, member: discord.User=None):
    """ Simple ban command """
    await ctx.guild.ban(member)
    print("banned" + " " + str(member))

if __name__ == '__main__':
    print('we are in main!')
    bot.run(TOKEN)    
