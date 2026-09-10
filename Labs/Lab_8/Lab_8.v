module q1_array_partition;
  int arr[] = '{9, 7, 4, 6, 2, 8, 6, 5};
  int pivot;
  int left[];  // Elements <= pivot
  int right[]; // Elements > pivot

  initial begin
    pivot = arr[$]; // Using last element as pivot
    
    foreach (arr[i]) begin
      if (arr[i] <= pivot) begin
        left = new[left.size() + 1](left);
        left[left.size() - 1] = arr[i];
      end else begin
        right = new[right.size() + 1](right);
        right[right.size() - 1] = arr[i];
      end
    end

    $display("Original Array : %p", arr);
    $display("Pivot Element  : %0d", pivot);
    $display("Left  (<= %0d)  : %p", pivot, left);
    $display("Right ( > %0d)  : %p", pivot, right);
  end
endmodule

module q2_max_consecutive;
  int arr[] = '{1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1};
  int max_count = 0;
  int current_count = 0;
  int target_val = 1;

  initial begin
    foreach (arr[i]) begin
      if (arr[i] == target_val) begin
        current_count++;
        if (current_count > max_count) begin
          max_count = current_count;
        end
      end else begin
        current_count = 0;
      end
    end

    $display("Array: %p", arr);
    $display("MAX. consecutive number : %0d --> %0d", target_val, max_count);
  end
endmodule

module q3_second_max;
  int arr[] = '{45, 34, 67, 89, 78};
  int max1, max2;

  initial begin
    if (arr.size() < 2) begin
      $display("Array must have at least 2 elements.");
      $finish;
    end

    // Initialize max1 and max2 with the first two elements
    if (arr[0] > arr[1]) begin
      max1 = arr[0];
      max2 = arr[1];
    end else begin
      max1 = arr[1];
      max2 = arr[0];
    end

    // Iterate through remaining elements
    for (int i = 2; i < arr.size(); i++) begin
      if (arr[i] > max1) begin
        max2 = max1;
        max1 = arr[i];
      end else if (arr[i] > max2 && arr[i] != max1) begin
        max2 = arr[i];
      end
    end

    $display("Array: %p", arr);
    $display("First Max  : %0d", max1);
    $display("Second Max : %0d", max2);
  end
endmodule

module q4_freq_counter;
  int arr[] = '{8, 3, 3, 4, 5, 6, 3, 5, 4, 6, 8, 7, 6, 4, 3, 5, 6};
  int freq[int]; // Associative array for element frequency counting

  initial begin
    foreach (arr[i]) begin
      if (freq.exists(arr[i]))
        freq[arr[i]]++;
      else
        freq[arr[i]] = 1;
    end

    $display("Array: %p", arr);
    $display("Frequency Counter Output:");
    foreach (freq[key]) begin
      $display("%0d --> %0d", key, freq[key]);
    end
  end
endmodule