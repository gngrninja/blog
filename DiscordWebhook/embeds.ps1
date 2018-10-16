#This file is not meant to be run all at once, it is used to go over examples in the blog post

# Example 1
# Embed with title, description, and color

#Store webhook url
$webHookUrl = 'yourhookurl'

#Create embed array
[System.Collections.ArrayList]$embedArray = @()

#Store embed values
$title       = 'Embed Title'
$description = 'Embed Description'
$color       = '1'

#Create embed object
$embedObject = [PSCustomObject]@{

    title       = $title
    description = $description
    color       = $color

}

#Add embed object to array
$embedArray.Add($embedObject) | Out-Null

#Create the payload
$payload = [PSCustomObject]@{

    embeds = $embedArray

}

#Send over payload, converting it to JSON
Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'

# Example 2
# Embed with title, description, color, and a thumbnail

#Store webhook url
$webHookUrl = 'yourhookurl'

#Create embed array
[System.Collections.ArrayList]$embedArray = @()

#Store embed values
$title       = 'Embed Title'
$description = 'Embed Description'
$color       = '1'

#Create thumbnail object
$thumbUrl = 'https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png' 
$thumbnailObject = [PSCustomObject]@{

    url = $thumbUrl

}

#Create embed object, also adding thumbnail
$embedObject = [PSCustomObject]@{

    title       = $title
    description = $description
    color       = $color
    thumbnail   = $thumbnailObject

}

#Add embed object to array
$embedArray.Add($embedObject) | Out-Null

#Create the payload
$payload = [PSCustomObject]@{

    embeds = $embedArray

}

#Send over payload, converting it to JSON
Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'