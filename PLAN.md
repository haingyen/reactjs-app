0. Security:
1. Infrastructure:
    - Terraform
    - AWS: VPC, IGW, SUBNETS(4 Public), SG, ROUTES, EC2(4)
3. Deploy:
    - Docker
    - Dockerhub
    - Docker Swarm
    - Trên các nodes cần cài Docker, Compose,
    - Chọn 1 node làm Manager và thực thi lệnh để khởi tạo Cluster: `docker swarm init --advertise-addr <MANAGER_IP>`
    - Xuất hiện lệnh join, thêm lệnh đó vào các Worker Nodes mong muốn
    - Xem Cluster: `docker node ls`
    - Tạo service: `docker service create --name <> --relicas <> -p <>:<> <image>:<tag>`
    - Xem service: `docker service ls`
    - Deploy lên Swarm: `docker stack deploy -c docker-compose.yml <service_name>`
4. App:
    - REACTJS
    - Web Server - Nginx
    - npm run build -> dist
    - Dockerfile -> Build image -> Push to Dockerhub
5. Version Control - Github + Webhook
6. CI/CD Pipeline - Jenkins
    - Jenkins server cùng VPC với Cluster
    - Jenkins server kết nối với Dockerhub 
    - Jenkins server kết nối với Manager node của Cluster qua Jenkins Agent