# -*- mode: python ; coding: utf-8 -*-
import os
from PyInstaller.utils.hooks import collect_data_files, collect_dynamic_libs

block_cipher = None

# Collect data files from packages that need them
datas = []
datas += collect_data_files('onnxruntime')
datas += collect_data_files('jieba')
datas += collect_data_files('janome')
datas += collect_data_files('pythainlp')
datas += collect_data_files('pdfminer')
datas += collect_data_files('pikepdf')
datas += collect_data_files('mahotas')

# App resources
datas += [
    ('resources', 'resources'),
    ('app',       'app'),
    ('modules',   'modules'),
]

# Hidden imports that PyInstaller may miss
hiddenimports = [
    # PySide6
    'PySide6.QtCore',
    'PySide6.QtGui',
    'PySide6.QtWidgets',
    'PySide6.QtNetwork',
    'PySide6.QtPrintSupport',
    'PySide6.QtSvg',
    # onnxruntime providers
    'onnxruntime.capi.onnxruntime_pybind11_state',
    # app modules
    'controller',
    'comic',
    'app.ui.splash_screen',
    # misc
    'keyring.backends.Windows',
    'keyring.backends.fail',
    'pkg_resources',
    'PIL._tkinter_finder',
]

a = Analysis(
    ['mukai.py'],
    pathex=['.'],
    binaries=[],
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[
        'matplotlib', 'tkinter', '_tkinter',
        'scipy', 'IPython', 'jupyter',
    ],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='MukaiTranslate',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,           # No terminal window
    disable_windowed_traceback=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='resources/icons/icon.ico',
    version=None,
)

coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='MukaiTranslate',
)
