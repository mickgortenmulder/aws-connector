import setuptools

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setuptools.setup(
    name="aws-connector",
    version="0.0.1",
    author="Mick Gortenmulder",
    author_email="mickgortenmulder@gmail.com",
    description="AWS connector",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/mickgortenmulder/aws-connector",
    project_urls={
        "Bug Tracker": "https://github.com/mickgortenmulder/aws-connector/issues",
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    package_dir={"": "src"},
    packages=setuptools.find_packages(where="src"),
    test_suite='tests',
    python_requires=">=3.9",
    install_requires=[
        'pyyaml>=5.4.1'
    ],
    scripts=['bin/aws-connector'],
)
