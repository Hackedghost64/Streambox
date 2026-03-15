import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/database_helper.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  List<Map<String, dynamic>> _downloads = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDownloads();
  }

  Future<void> _loadDownloads() async {
    final downloads = await DatabaseHelper.instance.getDownloads();
    setState(() {
      _downloads = downloads;
      _isLoading = false;
    });
  }

  Future<void> _deleteDownload(int id, String localPath) async {
    final file = File(localPath);
    if (await file.exists()) {
      await file.delete();
    }
    await DatabaseHelper.instance.deleteDownload(id);
    _loadDownloads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _downloads.isEmpty
              ? const Center(
                  child: Text('No downloaded movies yet.'),
                )
              : ListView.builder(
                  itemCount: _downloads.length,
                  itemBuilder: (context, index) {
                    final download = _downloads[index];
                    return ListTile(
                      leading: Image.file(
                        File(download['local_path']),
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(download['title']),
                      subtitle: Text(download['release_date']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteDownload(
                          download['_id'],
                          download['local_path'],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
