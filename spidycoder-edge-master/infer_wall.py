# import os

# os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'    # Suppress TensorFlow logging (1)

import tensorflow as tf

# tf.get_logger().setLevel('ERROR')           # Suppress TensorFlow logging (2)

import time
import numpy as np
from PIL import Image


def load_image_into_numpy_array(path):
    """Load an image from file into a numpy array.

    Puts image into numpy array to feed into tensorflow graph.
    Note that by convention we put it into a numpy array with shape
    (height, width, channels), where channels=3 for RGB.

    Args:
      path: the file path to the image

    Returns:
      uint8 numpy array with shape (img_height, img_width, 3)
    """
    return np.array(Image.open(path))


def infer_wall(image_path):
    # warnings.filterwarnings('ignore')   # Suppress Matplotlib warnings

    tf_model_dir_path = 'hold_detection_tf_model'

    # Load saved model and build the detection function
    print('Loading model...', end='')
    start_time = time.time()
    detect_fn = tf.saved_model.load(tf_model_dir_path)
    end_time = time.time()
    elapsed_time = end_time - start_time
    print('Done! Took {} seconds'.format(elapsed_time))

    print('Running inference for {}... '.format(image_path), end='')

    # tf.convert_to_tensor needs a numpy array as an argument
    image_np = load_image_into_numpy_array(image_path)
    # The input needs to be a tensor, convert it using `tf.convert_to_tensor`.
    input_tensor = tf.convert_to_tensor(image_np)
    # The model expects a batch of images, so add an axis with `tf.newaxis`.
    input_tensor = input_tensor[tf.newaxis, ...]

    detections = detect_fn(input_tensor)

    # All outputs are batches tensors.
    # Convert to numpy arrays, and take index [0] to remove the batch dimension.
    # We're only interested in the first num_detections.
    print(detections)
    num_detections = int(detections.pop('num_detections'))
    detections = {key: value[0, :num_detections].numpy() for key, value in detections.items()}
    detections['num_detections'] = num_detections

    # detection_classes should be ints.
    detections['detection_classes'] = detections['detection_classes'].astype(np.int64)

    print('Done')
    a = zip(detections['detection_boxes'], detections['detection_scores'])
    a = list(a)
    print(a)
    print(len(a))
    a = filter(lambda x: x[1] >= 0.6, a)
    a = list(a)
    print(a)
    print(len(a))
    a = list(map(lambda x: x[0], a))

    # Convert numpy float32 to python float
    result = [
        {
            'id': ind + 1,
            'x1': float(el[1]),
            'y1': float(el[0]),
            'x2': float(el[3]),
            'y2': float(el[2])
        } for ind, el in enumerate(a)
    ]
    print(result)
    return result


if __name__ == '__main__':
    infer_wall('wall-background.jpg')
