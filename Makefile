COLORBOX_PATH=sigal/themes/colorbox/static/css
GALLERIA_PATH=sigal/themes/galleria/static/css
PHOTOSWIPE_PATH=sigal/themes/photoswipe/static
PHOTOSWIPE_BLOG_PATH=sigal/themes/photoswipe_blog/static

all: colorbox galleria photoswipe photoswipe_blog

init:
	pip install -r requirements.txt

docs:
	make -C docs html

colorbox:
	cat $(COLORBOX_PATH)/{base,skeleton,colorbox,style}.css | cssmin > $(COLORBOX_PATH)/style.min.css

galleria:
	cat $(GALLERIA_PATH)/{normalize,style}.css | cssmin > $(GALLERIA_PATH)/style.min.css

photoswipe:
	cat $(PHOTOSWIPE_PATH)/styles.css $(PHOTOSWIPE_PATH)/default-skin/default-skin.css $(PHOTOSWIPE_PATH)/photoswipe.css | cssmin > $(PHOTOSWIPE_PATH)/styles.min.css

photoswipe_blog:
	cat $(PHOTOSWIPE_BLOG_PATH)/styles.css $(PHOTOSWIPE_BLOG_PATH)/default-skin/default-skin.css $(PHOTOSWIPE_BLOG_PATH)/photoswipe.css | cssmin > $(PHOTOSWIPE_BLOG_PATH)/styles.min.css

test:
	py.test

coverage:
	py.test --cov sigal --cov-report term --cov-report=html

publish: colorbox galleria photoswipe
	python setup.py register
	python setup.py sdist bdist_wheel
	twine upload dist/*

.PHONY: colorbox galleria photoswipe docs
