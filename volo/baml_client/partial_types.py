###############################################################################
#
#  Welcome to Baml! To use this generated code, please run the following:
#
#  $ pip install baml
#
###############################################################################

# This file was generated by BAML: please do not edit it. Instead, edit the
# BAML files and re-generate this code.
#
# ruff: noqa: E501,F401
# flake8: noqa: E501,F401
# pylint: disable=unused-import,line-too-long
# fmt: off
import baml_py
from enum import Enum
from pydantic import BaseModel, ConfigDict
from typing import Dict, List, Optional, Union, Literal

from . import types
from .types import Checked, Check

###############################################################################
#
#  These types are used for streaming, for when an instance of a type
#  is still being built up and any of its fields is not yet fully available.
#
###############################################################################


class ArchivistAnswer(BaseModel):
    
    
    answer: Optional[str] = None

class ArchivistFollowup(BaseModel):
    
    
    question: Optional[str] = None
    url: Optional[str] = None

class ArchivistFollowups(BaseModel):
    
    
    queries: List["ArchivistFollowup"]

class ChatHistoryItem(BaseModel):
    
    
    user_query: Optional[str] = None
    volo_response: Optional[str] = None

class ContactArchivist(BaseModel):
    
    
    user_roleplay_message: Optional[str] = None
    archivist_query: Optional[str] = None

class Resume(BaseModel):
    
    
    name: Optional[str] = None
    email: Optional[str] = None
    experience: List[Optional[str]]
    skills: List[Optional[str]]

class VoloResponse(BaseModel):
    
    
    response: Optional[str] = None
