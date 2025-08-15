import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  final String _greekMythologyContent = '''
    <!DOCTYPE html>
    <html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 20px;
                background: linear-gradient(135deg, #8B4513 0%, #DAA520 100%);
                color: #F5F5DC;
                line-height: 1.6;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.1);
                padding: 30px;
                border-radius: 15px;
                backdrop-filter: blur(10px);
            }
            h1 {
                text-align: center;
                color: #DAA520;
                font-size: 2.5em;
                margin-bottom: 30px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            }
            h2 {
                color: #DAA520;
                border-bottom: 2px solid #DAA520;
                padding-bottom: 10px;
                margin-top: 30px;
            }
            .god-section {
                background: rgba(255, 255, 255, 0.1);
                padding: 20px;
                margin: 20px 0;
                border-radius: 10px;
                border-left: 4px solid #DAA520;
            }
            .god-name {
                font-weight: bold;
                color: #DAA520;
                font-size: 1.2em;
            }
            .god-description {
                margin-top: 10px;
                color: #F5F5DC;
            }
            .highlight {
                background: rgba(218, 165, 32, 0.3);
                padding: 2px 5px;
                border-radius: 3px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>⚡ Greek Mythology ⚡</h1>
            
            <h2>The Olympian Gods</h2>
            
            <div class="god-section">
                <div class="god-name">Zeus - King of the Gods</div>
                <div class="god-description">
                    Zeus is the supreme ruler of Mount Olympus and the god of the sky, lightning, thunder, law, order, and justice. 
                    He wields the mighty thunderbolt and is known for his many romantic affairs with both goddesses and mortal women.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Hera - Queen of the Gods</div>
                <div class="god-description">
                    Hera is the goddess of marriage, women, childbirth, and family. She is Zeus's wife and sister, 
                    and is known for her jealousy and vengeful nature, especially towards Zeus's lovers and their children.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Poseidon - God of the Sea</div>
                <div class="god-description">
                    Poseidon rules over the oceans, seas, earthquakes, and horses. He carries a powerful trident 
                    and is known for his volatile temper and ability to cause storms and earthquakes.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Hades - God of the Underworld</div>
                <div class="god-description">
                    Hades rules over the dead and the underworld. He is often depicted as stern and just, 
                    though he is not evil. He rarely leaves his realm and is married to Persephone.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Athena - Goddess of Wisdom</div>
                <div class="god-description">
                    Athena is the goddess of wisdom, warfare, strategic warfare, handicrafts, and reason. 
                    She was born fully grown from Zeus's forehead and is one of the most respected Olympians.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Apollo - God of the Sun</div>
                <div class="god-description">
                    Apollo is the god of the sun, music, poetry, art, medicine, knowledge, and prophecy. 
                    He is also associated with archery and is often depicted with a lyre and bow.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Artemis - Goddess of the Hunt</div>
                <div class="god-description">
                    Artemis is the goddess of the hunt, wilderness, wild animals, the Moon, and chastity. 
                    She is Apollo's twin sister and is known for her independence and fierce protection of her virginity.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Ares - God of War</div>
                <div class="god-description">
                    Ares is the god of war, violence, bloodshed, and manly virtues. He represents the brutal 
                    and physical aspects of war, unlike Athena who represents strategic warfare.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Aphrodite - Goddess of Love</div>
                <div class="god-description">
                    Aphrodite is the goddess of love, beauty, pleasure, and procreation. She was born from 
                    the sea foam and is considered the most beautiful of all the goddesses.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Hephaestus - God of Fire</div>
                <div class="god-description">
                    Hephaestus is the god of fire, metalworking, stone masonry, forges, and the art of sculpture. 
                    He is the craftsman of the gods and created many of their weapons and armor.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Hermes - Messenger of the Gods</div>
                <div class="god-description">
                    Hermes is the god of trade, thieves, travelers, sports, athletes, and border crossings. 
                    He is the messenger of the gods and is known for his speed and cunning.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">Dionysus - God of Wine</div>
                <div class="god-description">
                    Dionysus is the god of wine, grape harvest, orchards and fruit, vegetation, fertility, 
                    festivity, insanity, ritual madness, religious ecstasy, and theatre.
                </div>
            </div>
            
            <h2>Famous Myths and Stories</h2>
            
            <div class="god-section">
                <div class="god-name">The Creation of the World</div>
                <div class="god-description">
                    In the beginning, there was only Chaos. From Chaos emerged Gaia (Earth), Tartarus (the Underworld), 
                    and Eros (Love). Gaia gave birth to Uranus (Sky), and together they created the Titans.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">The Trojan War</div>
                <div class="god-description">
                    The Trojan War was fought between the Greeks and the Trojans over Helen, the most beautiful 
                    woman in the world. The war lasted ten years and ended with the famous Trojan Horse.
                </div>
            </div>
            
            <div class="god-section">
                <div class="god-name">The Twelve Labors of Heracles</div>
                <div class="god-name">The Twelve Labors of Heracles</div>
                <div class="god-description">
                    Heracles (Hercules) was ordered to complete twelve impossible tasks as punishment. 
                    These included slaying the Nemean Lion, capturing the Golden Hind, and cleaning the Augean stables.
                </div>
            </div>
            
            <h2>Test Your Knowledge</h2>
            <p>Now that you've learned about the Greek gods and myths, test your knowledge with our quiz! 
            Challenge yourself to become an <span class="highlight">Olympian Master</span> of Greek mythology.</p>
            
            <p style="text-align: center; margin-top: 30px; font-style: italic;">
                "The gods are immortal, but their stories live forever in our hearts and minds."
            </p>
        </div>
    </body>
    </html>
  ''';

  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress: $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error:\nCode: ${error.errorCode}\nDescription: ${error.description}\nError Type: ${error.errorType}\nIs Fatal: ${error.isForMainFrame}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadHtmlString(_greekMythologyContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn More'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
