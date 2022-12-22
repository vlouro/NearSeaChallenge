# NearSeaChallenge

There is no framework needed.
iOS 16 is the minimum target

What is missing from the requirements:
    - The layout pattern on the list
    - On the about page there is the collection view missing, I couldn't find where to get the information to do that list.

Some problems that might appear:
    - After removing the text from the search, it might glitch on some images when reloading the original list
    - On Detail page there is sometimes a change between series, events, stories order
    - Some information missing from the Overview, I'm not sure if it was needed to request the character detail

Improvements:
    - Logic for images
    - Put the text to localized files to it could be translated for any language
    - Make generic views for example labels that use same font, color
    - Unit tests
    - Error handling
    - Offline database (I would use SQLite)
    - RxSwift to complement the MVVM pattern and clean some code when doing requests and fill the collections/tables or other elements
    
