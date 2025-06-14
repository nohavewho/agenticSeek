from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="agenticSeek",
    version="0.1.0",
    author="Fosowl",
    author_email="mlg.fcu@gmail.com",
    description="The open, local alternative to ManusAI",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/Fosowl/agenticSeek",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[],
    extras_require={
        "chinese": [
            "ordered_set",
            "pypinyin",
            "cn2an",
            "jieba",
        ],
    },
    entry_points={
        "console_scripts": [
            "agenticseek=main:main",
        ],
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.9",
)
