# Copyright (c) 2007-2008 The PyAMF Project.
# See LICENSE for details.

"""
Google App Engine adapter module.

Sets up basic type mapping and class mappings for using the Datastore API
in Google App Engine.

@see: U{Datastore API on Google App Engine (external)
<http://code.google.com/appengine/docs/datastore>}

@author: U{Nick Joyce<mailto:nick@boxdesign.co.uk>}
@since: 0.3.1
"""

from google.appengine.ext import db

import pyamf
from pyamf import amf0, amf3

def writeObjectAMF0(self, obj, *args, **kwargs):
    alias = self.context.getClassAlias(obj.__class__)
    remove = False

    if alias is None:
        remove = True
        self.context.class_aliases[obj.__class__] = pyamf.ClassAlias(obj.__class__, None)

    writeObjectAMF(self, obj, args, kwargs, remove)

def writeObjectAMF3(self, obj, *args, **kwargs):
    try:
        self.context.getClassDefinitionReference(obj)
    except pyamf.ReferenceError:
        alias = self.context.getClassAlias(obj.__class__)
        class_def = None
        remove = False

        if alias is None:
            remove = True
            alias = pyamf.ClassAlias(obj.__class__, None)
            self.context.class_aliases[obj.__class__] = alias

    writeObjectAMF(self, obj, args, kwargs, remove)

def writeObjectAMF(self, obj, args, kwargs, remove):
    """
    Writes an object that has already been prepared by writeObjectAMF0 or writeObjectAMF3.
    """
    try:
        obj._key = str(obj.key())
    except:
        obj._key = None
    self.writeObject(obj, *args, **kwargs)
    del obj._key
    if remove:
        self.context.class_aliases[obj.__class__] = None

def get_attrs_for_model(obj):
    """
    Returns a list of properties on an C{db.Model} instance.
    """
    return list(obj.__class__._properties) + ['_key']

def get_attrs_for_expando(obj):
    """
    Returns a list of dynamic properties on a C{db.Expando} instance.
    """
    return obj.dynamic_properties() + ['_key']

pyamf.register_class(db.Model, attr_func=get_attrs_for_model, metadata=['dynamic'])
pyamf.register_class(db.Expando, attr_func=get_attrs_for_expando, metadata=['dynamic'])

amf0.Encoder.writeGoogleModel = writeObjectAMF0
amf0.Encoder.type_map.insert(len(amf0.Encoder.type_map) - 1, ((db.Model,db.Expando), "writeGoogleModel"))

amf3.Encoder.writeGoogleModel = writeObjectAMF3
amf3.Encoder.type_map.insert(len(amf3.Encoder.type_map) - 1, ((db.Model,db.Expando), "writeGoogleModel"))
