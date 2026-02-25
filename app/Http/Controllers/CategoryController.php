<?php

namespace App\Http\Controllers;
use Illuminate\Support\Str;
use App\Models\Subcatagory;
use App\Models\Catagories;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
     public function index(Request $request)
    { 
        $query = Catagories::with('subcategories')
                        ->orderBy('id');

         if ($request->search) {
            $query->where('name', 'LIKE', '%' . $request->search . '%');
        }
$categories = $query->paginate(15)->withQueryString();
        return view('admin.categories', compact('categories'));
    }

      public function suggestions(Request $request)
    {
        $search = $request->search;

        $categories = Catagories::where('name', 'LIKE', "{$search}%")
                        ->limit(5)
                        ->pluck('name');

        return response()->json($categories);
    }

    public function store(Request $request)
    {
        
        $category = Catagories::create([
            'name' => $request->name,
            'slug' => Str::slug($request->name) 
        ]);

        if ($request->subcategories) {
            foreach ($request->subcategories as $sub) {
                if ($sub) {
                    Subcatagory::create([
                        'category_id' => $category->id,
                        'name' => $sub,
                        'slug' => Str::slug($sub),
                        'status' => 1
                    ]);
                }
            }
        }

        return back()->with('success', 'Category created successfully');
    }

    public function storeSubcategory(Request $request)
    {
        Subcatagory::create([
            'category_id' => $request->category_id,
            'name' => $request->name,
            'slug' => Str::slug($request->name),
            'status' => 1
        ]);

        return back()->with('success', 'Subcategory added');
    }

    public function destroy($id)
    {
        Catagories::findOrFail($id)->delete();
        return back()->with('success', 'Category deleted');
    }
public function toggleStatus($id)
{
    $category = Catagories::findOrFail($id);

    $category->status = $category->status ? 0 : 1;
    $category->save();

    return back()->with('success', 'Category status updated');
}
    public function destroySub($id)
    {
        Subcatagory::findOrFail($id)->delete();
        return back()->with('success', 'Subcategory deleted');
    }
}
