all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build all images"
	@echo "   2. make build-no-cache   - build all images whitout cache"
	@echo "   3. make clean            - remove all images"
	@echo ""

build:
	@docker build --tag=ros-amr:noetic-camel		ros-amr-noetic/.
	@docker build --build-arg GIT_USERNAME=${GIT_USERNAME} --build-arg GIT_PASSWORD=${GIT_PASSWORD}  --build-arg DS4=${DS4} --tag=camel:500-001    amr/500/.

build-no-cache:
	@docker build --no-cache --tag=ros-amr:noetic-camel		ros-amr-noetic/.
	@docker build --no-cache --build-arg GIT_USERNAME=${GIT_USERNAME} --build-arg GIT_PASSWORD=${GIT_PASSWORD}  --build-arg DS4=${DS4} --tag=camel:500-001   amr/500/.

clean:
	@docker rmi -f ros-amr:noetic-camel
	@docker rmi -f camel:500-001