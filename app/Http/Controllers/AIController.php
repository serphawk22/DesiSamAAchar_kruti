<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use OpenAI;

class AIController extends Controller
{
    public function generate(Request $request)
    {
        $client = OpenAI::client(env('OPENAI_API_KEY'));

        $prompt = "
        You are a professional financial news editor.

        Based on this topic:
        {$request->prompt}

        Generate:

        1. Improved SEO Title
        2. Short description (2 lines)
        3. Article outline (5 bullet points)
        4. SEO keywords

        Return in clean text format.
        ";

        $response = $client->chat()->create([
            'model' => 'gpt-4o-mini',
            'messages' => [
                ['role' => 'user', 'content' => $prompt],
            ],
        ]);

        return response()->json([
            'content' => $response->choices[0]->message->content
        ]);
    }
}