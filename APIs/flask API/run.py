from flask import Flask, render_template, request , redirect, jsonify
import tensorflow as tf
import numpy as np
from PIL import Image,ImageOps
from flask_cors import CORS

app = Flask(__name__, static_url_path='/static')
cors = CORS(app, resources={r"/predict": {"origins": "*"}})

model = tf.keras.models.load_model('mobileNetV2.h5',compile=False)

@app.route('/', methods=['GET', 'POST'])
	# model=pickle.load(open)
	#  return render_template('image_upload.html')

@app.route('/predict', methods=['POST'])
def predict():
    
    if request.method == 'POST':
        # get image file from request
        file = request.files['image']
        image = Image.open(file)
        #preprocessing the image
        target_size = (50, 50)  # Specify the target size for the image
        image = ImageOps.fit(image, target_size, Image.ANTIALIAS)
        gray_image = ImageOps.grayscale(image)
        arr_image=np.array(gray_image)
        image_array = np.expand_dims(arr_image, axis=0)
        prediction = model.predict(image_array)
        # return prediction to client
        
        # Set a threshold for classifying the prediction
        threshold = 0.5

        # Extract the probability values for each class
        class_probabilities = prediction[0]

        # Iterate through the class probabilities
        for i, prob in enumerate(class_probabilities):
            # Check if the probability is above the threshold
            if prob > threshold:
                # Make an output decision based on the class index (i)
                if i == 0:

                    res=1
                    print(" monkeypox detected")
                    # Perform action for class 0
                elif i == 1:
                    res=0
                    print(" Not monkeypox ")
                    # Perform action for class 1
            else:
                print("No prediction above threshold")
                # Perform action for no prediction above threshold
        # return render_template("image_upload.html",res=res)
        return jsonify(result=res)
    
    return 'Methods restricted'
	 
app.run(debug=True) 