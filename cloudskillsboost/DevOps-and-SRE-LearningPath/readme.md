



gcloud container clusters create hello-cluster \
    --zone us-central1-c \
    --release-channel regular \
    --cluster-version 1.29 \
    --enable-autoscaling \
    --num-nodes 3 \
    --min-nodes 2 \
    --max-nodes 6


2) kubectl get ns
3) kubectl create ns dev
3) kubectl create ns prod



export REGION="us-central1"
export ZONE="us-central1-c"
for file in sample-app/cloudbuild-dev.yaml sample-app/cloudbuild.yaml; do
    sed -i "s/<your-region>/${REGION}/g" "$file"
    sed -i "s/<your-zone>/${ZONE}/g" "$file"
done



### Git Commands
1) git add .
2) git commit -m "My First Commit"
3) git push


### Appendix
git branch -m main master
git fetch origin
git branch -u origin/master master
git remote set-head origin -a



### 3. Cloud Build Triggers

CloudBuild->Triggers->

### 4. Task 4. Deploy the first versions of the application

Build the first development deployment


kubectl -n dev get pods

kubectl -n dev get deployment


Expose the development-deployment deployment to a LoadBalancer service named dev-deployment-service on port 8080, and set the target port of the container to the one specified in the Dockerfile

kubectl -n dev expose deployment development-deployment --name dev-deployment-service --type=LoadBalancer --port=8080 --target-port=8080

kubectl -n dev get svc

kubectl -n dev delete svc development-deployment

34.46.248.249:8080/blue







## Build the first production deployment


kubectl -n prod get deployment

kubectl -n prod get pods


kubectl -n prod expose deployment production-deployment --name prod-deployment-service --type=LoadBalancer --port=8080 --target-port=8080



kubectl -n prod get svc 
34.136.146.49

http://34.136.146.49:8080/blue



### Task 5. Deploy the second versions of the application

In this section, you build the second version of the production application and the development application.

Build the second development deployment

1. Switch back to the dev branch.

 git checkout dev

2. In the main.go file, update the main() function to the following:
```
func main() {
	http.HandleFunc("/blue", blueHandler)
	http.HandleFunc("/red", redHandler)
	http.ListenAndServe(":8080", nil)
}
```

3. Add the following function inside of the main.go file:

```

func redHandler(w http.ResponseWriter, r *http.Request) {
	img := image.NewRGBA(image.Rect(0, 0, 100, 100))
	draw.Draw(img, img.Bounds(), &image.Uniform{color.RGBA{255, 0, 0, 255}}, image.ZP, draw.Src)
	w.Header().Set("Content-Type", "image/png")
	png.Encode(w, img)
}
```



###

git branch -a
git checkout master
git branch -a


