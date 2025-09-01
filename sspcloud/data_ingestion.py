""" Data ingestion python script for this tutorial

Processes:

1. fetch data from https://minio.lab.sspcloud.fr/projet-formation/diffusion/mlops/data/firm_activity_data.parquet
2. Convert label into NACE section (level 1)
3. Drop duplicates of data
4. Sample 20000 rows
5. Train test split 90% / 10% without stratification
6. Save train test into data/raw/

"""


import pandas as pd

from sklearn.model_selection import train_test_split

SEED = 42

df = pd.read_parquet(
    "https://minio.lab.sspcloud.fr/projet-formation/diffusion/mlops/data/firm_activity_data.parquet"
)


nace_2digit_to_section = {
    # Section A: Agriculture, forestry and fishing
    "01": "A", "02": "A", "03": "A",

    # Section B: Mining and quarrying
    "05": "B", "06": "B", "07": "B", "08": "B", "09": "B",

    # Section C: Manufacturing
    "10": "C", "11": "C", "12": "C", "13": "C", "14": "C",
    "15": "C", "16": "C", "17": "C", "18": "C", "19": "C",
    "20": "C", "21": "C", "22": "C", "23": "C", "24": "C",
    "25": "C", "26": "C", "27": "C", "28": "C", "29": "C",
    "30": "C", "31": "C", "32": "C", "33": "C",

    # Section D: Electricity, gas, steam and air conditioning supply
    "35": "D",

    # Section E: Water supply; sewerage, waste management and remediation
    "36": "E", "37": "E", "38": "E", "39": "E",

    # Section F: Construction
    "41": "F", "42": "F", "43": "F",

    # Section G: Wholesale and retail trade
    "45": "G", "46": "G", "47": "G",

    # Section H: Transportation and storage
    "49": "H", "50": "H", "51": "H", "52": "H", "53": "H",

    # Section I: Accommodation and food service activities
    "55": "I", "56": "I",

    # Section J: Information and communication
    "58": "J", "59": "J", "60": "J", "61": "J", "62": "J", "63": "J",

    # Section K: Financial and insurance activities
    "64": "K", "65": "K", "66": "K",

    # Section L: Real estate activities
    "68": "L",

    # Section M: Professional, scientific and technical activities
    "69": "M", "70": "M", "71": "M", "72": "M", "73": "M", "74": "M", "75": "M",

    # Section N: Administrative and support service activities
    "77": "N", "78": "N", "79": "N", "80": "N", "81": "N", "82": "N",

    # Section O: Public administration and defence
    "84": "O",

    # Section P: Education
    "85": "P",

    # Section Q: Human health and social work activities
    "86": "Q", "87": "Q", "88": "Q",

    # Section R: Arts, entertainment and recreation
    "90": "R", "91": "R", "92": "R", "93": "R",

    # Section S: Other service activities
    "94": "S", "95": "S", "96": "S",

    # Section T: Activities of households as employers
    "97": "T", "98": "T",

    # Section U: Activities of extraterritorial organizations
    "99": "U"
}

df['label'] = df['nace'].apply(lambda x: x[:2]).map(nace_2digit_to_section)
df = df.drop(columns=['nace'])
df = df.drop_duplicates(subset=['text', 'label'])
df = df.sample(n=20000, random_state=SEED)
df_train, df_test = train_test_split(df, test_size=0.1, random_state=SEED)

df_train.to_csv('data/raw/nace_train.csv')
df_test.to_csv('data/raw/nace_test.csv')