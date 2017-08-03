# RecSys Challenge 2015
Given a sequence of click events performed by some user during a typical session in an e-commerce website, the goal is to predict whether the user is going to buy something or not, and if he is buying, what would be the items he is going to buy. The task could therefore be divided into two sub goals:

- Is the user going to buy items in this session? Yes|No
- If yes, what are the items that are going to be bought?

See http://2015.recsyschallenge.com/challenge.html

## The Data

### Training Data Files
The training data comprises two different files:

- yoochoose-clicks.dat - Click events. Each record/line in the file has the following fields:
 1. Session ID – the id of the session. In one session there are one or many clicks.
 2. Timestamp – the time when the click occurred.
 3. Item ID – the unique identifier of the item.
 4. Category – the category of the item.

- yoochoose-buys.dat - Buy events. Each record/line in the file has the following fields:
 1. Session ID - the id of the session. In one session there are one or many buying events.
 2. Timestamp - the time when the buy occurred.
 3. Item ID – the unique identifier of item.
 4. Price – the price of the item.
 5. Quantity – how many of this item were bought.

The Session ID in yoochoose-buys.dat will always exist in the yoochoose-clicks.dat file – the records with the same Session ID together form the sequence of click events of a certain user during the session. The session could be short (few minutes) or very long (few hours), it could have one click or hundreds of clicks. All depends on the activity of the user.

### Test File
The Test data is one file:

- yoochoose-test.dat - identically structured as the yoochoose-clicks.dat of the training data
 1. Session ID
 2. Timestamp
 3. Item ID
 4. Category

## Evaluation Measure
Consequently, the evaluation is taking into consideration the ability to predict both aspects – whether the sessions end with buying event, and what were the items that have been bought. Let’s define the following:

- Sl – sessions in submitted solution file
- S - All sessions in the test set
- s – session in the test set
- Sb – sessions in test set which end with buy
- As – predicted bought items in session s
- Bs – actual bought items in session s

## Tutorial - How to Preprocess
To preprocess the dataset files, you must have the dataset file in `$HOME`. The output train and test files will be saved in the same folder:

```
cd examples/rsc15
python3 preprocess.py
```

The output training and test files will be:

```
-rw-r--r--  1 root root    2413715 Jul 25 15:21 rsc15_test.txt
-rw-r--r--  1 root root 1041036052 Jul 25 15:21 rsc15_train_full.txt
-rw-r--r--  1 root root 1039062495 Jul 25 15:24 rsc15_train_tr.txt
-rw-r--r--  1 root root    1973579 Jul 25 15:24 rsc15_train_valid.txt
```

## Tutorial - How to Train and Test
To train a already processed dataset.

```
cd examples/rsc15
python3 run_rsc15.py
```

During the traning and testing the output will be written to `$HOME/theano.log` file, so it could be worth to `$HOME/theano.log`.


## Tutorial - How to Predict
To predict new events in a session.

```
cd examples/rsc15
python3 predict_rsc15.py
```

During the prediction the output will be written to `$HOME/theano.log` file.


