#remove previous docker images
docker rmi asia-northeast3-docker.pkg.dev/webrtc-demo-413508/webrtc-demo2/webrtc-demo2:latest
docker rmi webrtc-demo2:latest

#rebuild docker images
docker build -t webrtc-demo2 .
docker tag webrtc-demo2 asia-northeast3-docker.pkg.dev/webrtc-demo-413508/webrtc-demo2/webrtc-demo2
#push to google artifact register
docker push asia-northeast3-docker.pkg.dev/webrtc-demo-413508/webrtc-demo2/webrtc-demo2