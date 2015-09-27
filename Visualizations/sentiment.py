from pymongo import MongoClient
import urllib
import requests

db_client = MongoClient('localhost')
db = db_client.psosm_mid_sem_development
collection = db.tweets


def get_sentiments():

    tweets_3 = collection.find()
    positive_count_3 = 0
    neutral_count_3 = 0
    negative_count_3 = 0
    x=1
    for tweet in tweets_3:
        print x
        x +=1
        text1 = tweet['text']
        text = text1.encode("utf8")         
        r=requests.post('http://www.sentiment140.com/api/bulkClassify',data=text)
        output = r.text
        rate = int(output[1])

        if rate == 2:        
            neutral_count_3  += 1
            
        elif rate == 0:
            negative_count_3  += 1
            
        elif rate == 4:
            positive_count_3  += 1
        if x==150:
            break
            
    print 'hello'
    print positive_count_3 
    
    db.sentiment_tw.insert({'positive' : int(positive_count_3), 'negative' : int(negative_count_3), 'neutral' : int(neutral_count_3)})

get_sentiments()
