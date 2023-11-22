from ultralytics import YOLO
import torch
import time

device = "cuda" if torch.cuda.is_available() else "cpu"
print(f"Using device `{device}` for inference")

# Load a model
# model = YOLO("yolov8n.yaml")  # build a new model from scratch
# model = YOLO("yolov8n.pt")  # load a pretrained model (recommended for training)
model = YOLO(
    "/root/numan/yolo-v8-demo/model_trained.pt"
)  # load a pretrained model (recommended for training)

# Use the model
# model.train(data="coco128.yaml", epochs=3)  # train the model
# metrics = model.val()  # evaluate model performance on the validation set

start_time = time.perf_counter()
results = model(
    "/root/numan/yolo-v8-demo/images", save=True
)  # predict on an image
# results = model(
#     "/root/numan/yolo-v8-demo/images"
# )  # predict on an image
end_time = time.perf_counter()

print(f"\n*** Time taken: {end_time - start_time:0.4f} seconds ***\n")

# result = results[0].boxes.data.cpu().numpy()

# print(f"Results: {result}")  # print results as pandas DataFrame

# path = model.export(format="onnx")  # export the model to ONNX format
